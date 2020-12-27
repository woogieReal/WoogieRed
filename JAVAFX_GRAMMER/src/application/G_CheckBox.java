package application;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;

public class G_CheckBox {

	@FXML
    private CheckBox GameCheckBox;
    @FXML
    private CheckBox ExerciseCheckBox;
    @FXML
    private CheckBox YoutubeCheckBox;
    @FXML
    private CheckBox sleepingCheckBox;
    @FXML
    private TextField ResultTextField;
    @FXML
    private Button SubmitButton;
    
    
    public void checkedSubmit(ActionEvent event) {
    	
    	StringBuilder hobby = new StringBuilder();
    	
    	if(GameCheckBox.isSelected()) {
    		hobby.append("Game, ");
    	}
    	
    	if(ExerciseCheckBox.isSelected()) {
    		hobby.append("Exercise, ");
    	}
    	
    	if(YoutubeCheckBox.isSelected()) {
    		hobby.append("Youtube, ");
    	}
    	
    	if(sleepingCheckBox.isSelected()) {
    		hobby.append("Sleeping");
    	}
    	
    	ResultTextField.setText(hobby.toString());
    	
    }
    
    
    
	
}
