package com.example.first_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.tensorflow.lite.Interpreter
import java.io.FileInputStream
import java.nio.MappedByteBuffer
import java.nio.channels.FileChannel
import java.nio.ByteBuffer
import android.content.res.AssetManager

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.first_app/tflite"
    private var interpreter: Interpreter? = null
    private var labels: List<String> = listOf()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "loadModel" -> {
                        try {
                            loadModel()
                            result.success("Model loaded successfully")
                        } catch (e: Exception) {
                            result.error("LOAD_ERROR", e.message, null)
                        }
                    }
                    "runInference" -> {
                        try {
                            val imagePath = call.argument<String>("imagePath")!!
                            val output = runInference(imagePath)
                            result.success(output)
                        } catch (e: Exception) {
                            result.error("INFERENCE_ERROR", e.message, null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun loadModel() {
        val assetManager = this.assets
        val modelInputStream = assetManager.open("latest_snapchat.tflite")
        val size = modelInputStream.available()
        val buffer = ByteArray(size)
        modelInputStream.read(buffer)
        modelInputStream.close()

        val mmap = ByteBuffer.allocateDirect(buffer.size)
        mmap.put(buffer)
        mmap.position(0)

        interpreter = Interpreter(mmap)

        val labelInputStream = assetManager.open("labels.txt")
        labels = labelInputStream.bufferedReader().readLines()
        labelInputStream.close()
    }

    private fun runInference(imagePath: String): Map<String, Any> {
        if (interpreter == null) {
            throw Exception("Model not loaded")
        }

        try {
            val bitmap = android.graphics.BitmapFactory.decodeFile(imagePath)
                ?: throw Exception("Failed to decode image")
            
            val resized = android.graphics.Bitmap.createScaledBitmap(bitmap, 224, 224, true)
            
            val input = java.nio.ByteBuffer.allocateDirect(1 * 224 * 224 * 3 * 4)
            input.order(java.nio.ByteOrder.nativeOrder())
            
            for (y in 0 until 224) {
                for (x in 0 until 224) {
                    val pixel = resized.getPixel(x, y)
                    val r = ((pixel shr 16) and 0xff).toFloat() / 255f
                    val g = ((pixel shr 8) and 0xff).toFloat() / 255f
                    val b = (pixel and 0xff).toFloat() / 255f
                    
                    input.putFloat(r)
                    input.putFloat(g)
                    input.putFloat(b)
                }
            }
            input.position(0)

            val output = Array(1) { FloatArray(labels.size) }
            interpreter?.run(input, output)

            val predictions = output[0]
            var maxIndex = 0
            var maxConfidence = 0f
            
            for (i in predictions.indices) {
                if (predictions[i] > maxConfidence) {
                    maxConfidence = predictions[i]
                    maxIndex = i
                }
            }

            val label = if (maxIndex in labels.indices) labels[maxIndex].trim() else "Unknown"
            
            return mapOf(
                "label" to label,
                "confidence" to maxConfidence.toDouble()
            )
        } catch (e: Exception) {
            android.util.Log.e("TFLite", "Inference error", e)
            throw Exception("Inference failed: ${e.message}")
        }
    }
}
