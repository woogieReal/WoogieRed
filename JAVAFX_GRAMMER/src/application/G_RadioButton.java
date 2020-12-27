package application;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;

public class G_RadioButton {

	//라디오버튼 그룹화 필요/toggle group
	@FXML
	private RadioButton DogRadioButton;
	@FXML
	private RadioButton CatRadioButton;
	@FXML
	private RadioButton RabbitRadioButton;
	@FXML
	private ToggleGroup Group;
	@FXML
	private Button SubmitButton;
	@FXML
	private TextField ResultTextField;

	public void submit(ActionEvent event) {

		StringBuilder sb = new StringBuilder("I like ");

		if (DogRadioButton.isSelected()) {
			sb.append("a dog.");
		} else if (CatRadioButton.isSelected()) {
			sb.append("a cat.");
		} else if (RabbitRadioButton.isSelected()) {
			sb.append("a rabbit.");
		}
		
		ResultTextField.setText(sb.toString());

	}

}
