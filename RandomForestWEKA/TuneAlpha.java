package RandomForestsGiniAlpha;

import java.io.File;
import java.util.Arrays;
import java.util.Random;

import weka.classifiers.Evaluation;
import weka.classifiers.trees.RandomForestAdjustedGini;
import weka.core.Instances;
import weka.core.Utils;
import weka.core.converters.ConverterUtils.DataSource;

public class TuneAlpha {

	public static void main(String[] args) {
		 
	// Add the directory where you put the datasets here
    String dirStr = "/home/ubuntu/Dropbox/Java/weka-3-7-13/src/main/java/RandomForestsGiniAlpha/Datasets";         
     
    // Chose the possible alpha to tune
    String[] alphas = {"0.005","0.01","0.05","0.1","0.3","0.5","0.7","1"};
    double[] AUCalpha = new double[alphas.length];
    
    // How many folds for cross-validation
    int CV = 2;
    // How many repetitions of cross-validation
    int trial, times = 3;
    
    // Parameters for Random Forests
    // Number of trees
    String numTrees = "1000";
    
    // Parallelization parameters
    // Number of cores in your machine
    String slots = "36";
    
    // Further variables
    double meanAUC = 0;
       
    
    File dir = new File(dirStr);
    String[] children = dir.list();
    Arrays.sort(children);
    try{
	    if (children == null) {
	      System.out.println("Either dir does not exist or is not a directory");          	
	    } else {
	      for (int f=0; f<children.length; f++) {
	       	
	      	// Get filename of file or directory
	        String filename = children[f];
	        System.out.println("Dataset: " + filename);
	        
	        String source = dirStr + "/" + filename;
	        
	        Instances data = DataSource.read(source);
	        data.setClassIndex(data.numAttributes()-1);
	        
          Evaluation eval;
          // Number of random attributes for Random Forests -> sqrt(n attributes)
          String rndAtt = "" + Math.round( Math.sqrt(data.numAttributes() + 1) ) ;
          
          int a = 0;        
          for (String alpha: alphas){
	          trial = 1;
	          meanAUC = 0;
	          while (trial <= times ){
	          	RandomForestAdjustedGini rf = new RandomForestAdjustedGini();
	          	
	          	// Set the options 
	            String[] options = {"-C", "aginialphagain","-A",alpha,"-I", numTrees, "-K", rndAtt, "-num-slots", slots};
	            rf.setOptions(options);
	            
	            eval = new Evaluation(data);
	            eval.crossValidateModel(rf, data, CV, new Random(trial));
	            meanAUC += eval.weightedAreaUnderROC()*100;
	            trial++;
	          }
	          meanAUC /= times;
	          AUCalpha[a++] = meanAUC;
	          System.out.println("Random Forests with AGini(alpha = " +  alpha + ") gain, AUC = " + meanAUC);
          }
          System.out.println();
	      int bestAlpha = Utils.maxIndex(AUCalpha);
	      System.out.println("Best alpha is " + alphas[bestAlpha] + "\n");          
	      }
	    }
    }catch(Exception e) { e.printStackTrace(); }
	}

}
