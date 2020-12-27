package application;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;

public class G_ComboBox {

	//ComboBox
	ObservableList<String> TestComboBoxList = FXCollections.observableArrayList("first","second","third");
	@FXML
	private ComboBox<String> TestComboBox;
    @FXML
    private Label TestLabel;
    @FXML
    private Button ComboBoxButton;
	
	public void initialize() {
		
		TestComboBox.setValue("first");
		TestComboBox.setItems(TestComboBoxList);
		
	}
	
	public void TestL() {
		
		String a = TestComboBox.getValue();
		TestLabel.setText(a);
	}
	
}
