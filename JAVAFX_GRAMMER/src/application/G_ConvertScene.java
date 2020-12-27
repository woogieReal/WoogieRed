package application;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.stage.Stage;

public class G_ConvertScene {

	@FXML
	private Button ComboBoxButton;
	@FXML
	private Button CheckBoxButton;
	@FXML
	private Button RadioButtonButton;
	@FXML
	private Button ListViewButton;
	@FXML
	private Button TreeViewButton;

	public void toComboBox(ActionEvent event) {

		try {
			Parent comboBox = FXMLLoader.load(getClass().getResource("ComboBox.fxml"));
			Scene scene = new Scene(comboBox);
			Stage primaryStage = (Stage) ComboBoxButton.getScene().getWindow();
			primaryStage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void toCheckBox(ActionEvent event) {

		try {
			Parent comboBox = FXMLLoader.load(getClass().getResource("CheckBox.fxml"));
			Scene scene = new Scene(comboBox);
			Stage primaryStage = (Stage) ComboBoxButton.getScene().getWindow();
			primaryStage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void toRadioButton(ActionEvent event) {

		try {
			Parent comboBox = FXMLLoader.load(getClass().getResource("RadioButton.fxml"));
			Scene scene = new Scene(comboBox);
			Stage primaryStage = (Stage) ComboBoxButton.getScene().getWindow();
			primaryStage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void toListView(ActionEvent event) {

		try {
			Parent comboBox = FXMLLoader.load(getClass().getResource("ListView.fxml"));
			Scene scene = new Scene(comboBox);
			Stage primaryStage = (Stage) ComboBoxButton.getScene().getWindow();
			primaryStage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void toTreeView(ActionEvent event) {

		try {
			Parent comboBox = FXMLLoader.load(getClass().getResource("TreeView.fxml"));
			Scene scene = new Scene(comboBox);
			Stage primaryStage = (Stage) ComboBoxButton.getScene().getWindow();
			primaryStage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
