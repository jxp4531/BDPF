package com.xunfang.bdpf.mllib.regression.service;

import java.util.HashMap;
import java.util.Map;

import scala.Tuple2;

import org.apache.spark.api.java.function.Function2;
import org.apache.spark.api.java.JavaPairRDD;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.api.java.function.Function;
import org.apache.spark.api.java.function.PairFunction;
import org.apache.spark.mllib.regression.LabeledPoint;
import org.apache.spark.mllib.tree.RandomForest;
import org.apache.spark.mllib.tree.model.RandomForestModel;
import org.apache.spark.mllib.util.MLUtils;

import com.xunfang.bdpf.mllib.impl.AlgorithmFactory;

public class RandomForestRegressionService {
	/**
	 * 0 初始化环境配置
	 */
	static JavaSparkContext jsc;
	private String[] name;

	public RandomForestRegressionService(String[] name) {
		this.name = name;
		this.jsc = AlgorithmFactory.initJavaSparkEnv("RandomForestRegression", 4);
	}

	/**
	 * 1 加载解析数据
	 */

	public static JavaRDD<LabeledPoint> load(JavaSparkContext jsc, String path) {
		JavaRDD<LabeledPoint> data = MLUtils.loadLibSVMFile(jsc.sc(), path).toJavaRDD();
		return data;
	}
	/**
	 * 2 切分数据集(训练数据集70% 测试数据集30%)
	 * 
	 * @param DataSet 加载的整体数据集
	 * @return map,包含训练数据集、测试数据集
	 */
	public static Map<String, JavaRDD<LabeledPoint>> slitData(JavaRDD<LabeledPoint> DataSet, Double factor1,
			Double factor2) {
		Map<String, JavaRDD<LabeledPoint>> mapData = new HashMap<String, JavaRDD<LabeledPoint>>();

		JavaRDD<LabeledPoint>[] splits = DataSet.randomSplit(new double[] { factor1, factor2 }, 11L);

		JavaRDD<LabeledPoint> training = splits[0].cache();
		JavaRDD<LabeledPoint> test = splits[1];

		mapData.put("trainingDataSet", training);
		mapData.put("testDataSet", test);

		return mapData;
	}
	/**
	 * 3 随机森林 回归模型训练
	 * 
	 * @param mapData
	 * @return RandomForestModel 
	 */
	public static RandomForestModel train(Map<String, JavaRDD<LabeledPoint>> mapData) {

		Map<Integer, Integer> categoricalFeaturesInfo = new HashMap<Integer, Integer>();
	    Integer numTrees = 3; // Use more in practice.
	    String featureSubsetStrategy = "auto"; // Let the algorithm choose.
	    String impurity = "variance";
	    Integer maxDepth = 4;
	    Integer maxBins = 32;
	    Integer seed = 12345;

	    final RandomForestModel model = RandomForest.trainRegressor(mapData.get("trainingDataSet"),
	    	      categoricalFeaturesInfo, numTrees, featureSubsetStrategy, impurity, maxDepth, maxBins, seed);

		return model;
	}
	/**
     * 4 在测试集上评估模型
     * @param model
     * @param mapData
     * @return
     */
    public static JavaPairRDD<Double, Double> getPredictionAndLabels(RandomForestModel model,Map<String, JavaRDD<LabeledPoint>> mapData){
    	
    	JavaPairRDD<Double, Double> predictionAndLabel =
    			mapData.get("testDataSet").mapToPair(new PairFunction<LabeledPoint, Double, Double>() {
    			    @Override
    			    public Tuple2<Double, Double> call(LabeledPoint p) {
    			      return new Tuple2<Double, Double>(model.predict(p.features()), p.label());
    			    }
    			  });
    	
    	return predictionAndLabel;
    }
    
    /**
   	 * 5 计算测试误差
   	 * 
   	 * @param predictionAndLabel
   	 * @param mapData
   	 * @return double testErr
   	 * 
   	 */
   	public static double testErr(JavaPairRDD<Double, Double> predictionAndLabel,
   			Map<String, JavaRDD<LabeledPoint>> mapData) {

   		Double testErr = predictionAndLabel.map(new Function<Tuple2<Double, Double>, Double>() {
   			@Override
   			public Double call(Tuple2<Double, Double> pl) {
   				Double diff = pl._1() - pl._2();
   				return diff * diff;
   			}
   		}).reduce(new Function2<Double, Double, Double>() {
   			@Override
   			public Double call(Double a, Double b) {
   				return a + b;
   			}
   		}) / mapData.get("testDataSet").count();

   		return testErr;
   	}
   	/**
	 * 6 保存模型
	 */

	public static void saveModel(JavaSparkContext jsc, RandomForestModel model, String path) {

		model.save(jsc.sc(), path);
	}

	/**
	 * 7 加载模型
	 */
	public static void loadModel(JavaSparkContext jsc, String path) {
		RandomForestModel.load(jsc.sc(), path);
	}

	/**
	 * 8 关闭 JavaSparkContext 对象
	 */
	public static void stopSC(JavaSparkContext jsc) {
		AlgorithmFactory.stopJavaSparkContext(jsc);
	}
	
	/**
	 * 测试
	 * @param args
	 */
	public static void main(String[] args) {
		// 初始化环境
		jsc = AlgorithmFactory.initJavaSparkEnv("RandomForestRegression", 4);
		// 加载解析数据
		JavaRDD<LabeledPoint> DataSet = load(jsc,
				"C:/Users/16273/Desktop/Apache/spark-1.6.3-bin-hadoop2.6/data/mllib/sample_libsvm_data.txt");
		// 切分数据集
		Map<String, JavaRDD<LabeledPoint>> mapData = slitData(DataSet, 0.7, 0.3);
		// 模型训练
		RandomForestModel  model = train(mapData);
		JavaPairRDD<Double, Double> predictionAndLabel = getPredictionAndLabels(model, mapData);

		System.out.println("Test Mean Squared Error: " + testErr(predictionAndLabel,mapData));

		System.out.println("******************************************************************");

		System.out.println("Learned regression forest model:\n" + model.toDebugString());

		stopSC(jsc);
	}

}
