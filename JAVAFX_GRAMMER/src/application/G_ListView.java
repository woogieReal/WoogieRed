package application;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;

public class G_ListView {

	ObservableList<String> TestListViewList = FXCollections.observableArrayList("KIM JAEUK","YOU MIYEON","UGIUMI");
	@FXML
	private ListView<String> TestListView;
	@FXML
	private Label TestLabel;
	
	public void initialize() {
		
		TestListView.setItems(TestListViewList);
		
	}
	
	public void click() {

		ObservableList<String> name = TestListView.getSelectionModel().getSelectedItems();
		String result = name.toString();
		TestLabel.setText(result.substring(1, result.length()-1));
		//그대로 출력하면 [String]으로 출력되므로 제거한다.

	}
	
}
