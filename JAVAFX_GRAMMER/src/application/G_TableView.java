package application;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

public class G_TableView {

	 @FXML
	 private TableView<Member2> memberTableView;
	 @FXML
	 private TableColumn<Member2, String> nameColumn;
	 @FXML
	 private TableColumn<Member2, String> addressColumn;
	    
	public void initialize() {
		 
		 nameColumn.setCellValueFactory(new PropertyValueFactory<Member2, String>("name"));
		 addressColumn.setCellValueFactory(new PropertyValueFactory<Member2, String>("address"));
		
		 ObservableList<Member2> Member2TableViewList = FXCollections.observableArrayList();
		 Member2TableViewList.add(new Member2("김재욱","인천"));
		 Member2TableViewList.add(new Member2("유미연","김포"));
		 memberTableView.setItems(Member2TableViewList);
		 
		 
		 
		 
	 }
	 
	 
	
}
