package application;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TreeItem;
import javafx.scene.control.TreeView;
import javafx.scene.input.MouseEvent;

public class G_TreeView {

	@FXML
	private TreeView<String> TestTreeView;
	@FXML
	private Label TestLabel;
	@FXML
	private Button TestButton;

	@SuppressWarnings("unchecked")
	public void initialize() {

		TreeItem<String> root = new TreeItem<>("생물");
		TestTreeView.setRoot(root);

		TreeItem<String> nodeA = new TreeItem<>("동물");
		TreeItem<String> nodeB = new TreeItem<>("식물");
		root.getChildren().addAll(nodeA, nodeB);

		TreeItem<String> nodeA_a = new TreeItem<>("개");
		TreeItem<String> nodeA_b = new TreeItem<>("고양이");
		TreeItem<String> nodeA_c = new TreeItem<>("소");
		nodeA.getChildren().addAll(nodeA_a, nodeA_b, nodeA_c);

	}

	public void doubleClick(MouseEvent mouseEvent) {
		if (mouseEvent.getClickCount() == 2) {
			TreeItem<String> item = TestTreeView.getSelectionModel().getSelectedItem();
			String result = item.toString();
			TestLabel.setText(result.substring(18, result.length() - 2));
			// 기본값 : [TreeItem [ value: 고양이 ]
		}

	}
}
