package RandomForestsGiniAlpha;

import weka.classifiers.Evaluation;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;
import weka.classifiers.trees.RandomForestAdjustedGini;

public class TestRandomForestAdjustedGini {

	public static void main(String[] args) {
		// Add the directory where you put the datasets here
    String source = "/home/simone/Dropbox/Java/weka-3-7-13/src/main/java/RandomForestsGiniAlpha/Datasets/tae.arff";         
    try{
	    Instances data = DataSource.read(source);
	    data.setClassIndex(data.numAttributes()-1);
	    
	     Evaluation eval;
       // Number of random attributes for Random Forests -> sqrt(n attributes)
       String rndAtt = "" + Math.round( Math.sqrt(data.numAttributes() + 1) ) ;
       
       RandomForestAdjustedGini rf = new RandomForestAdjustedGini();
     	 // Set the options 
       String[] options = {"-K", rndAtt, "-C", "aginialphagain", "-A", "0.1"};
       rf.setOptions(options);
       
       rf.buildClassifier(data);
       System.out.println(rf);      
       
    }catch(Exception e) { e.printStackTrace(); }

	}

}
