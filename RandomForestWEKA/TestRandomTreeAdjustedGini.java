package RandomForestsGiniAlpha;

import weka.classifiers.Evaluation;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.classifiers.trees.RandomTreeAdjustedGini;

public class TestRandomTreeAdjustedGini {

	public static void main(String[] args) {
		// Add the directory where you put the datasets here
    String source = "/home/simone/Dropbox/Java/weka-3-7-13/src/main/java/RandomForestsGiniAlpha/Datasets/tae.arff";         
    try{
	    Instances data = DataSource.read(source);
	    data.setClassIndex(data.numAttributes()-1);
	    
	     Evaluation eval;
       // Number of random attributes for Random Forests -> sqrt(n attributes)
       String rndAtt = "" + Math.round( Math.sqrt(data.numAttributes() + 1) ) ;
       
       RandomTreeAdjustedGini tree = new RandomTreeAdjustedGini();
     	 // Set the options 
       String[] options = {"-K", rndAtt, "-C", "aginialphagain", "-A", "0.1"};
       tree.setOptions(options);
              
       tree.buildClassifier(data);
       System.out.println(tree);      
       
    }catch(Exception e) { e.printStackTrace(); }

	}

}
