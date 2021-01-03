package application;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.paint.Color;

public class G_Set {

	@FXML
	private Button TestButton;

	public void TestButton(ActionEvent event) {
		try {

			TestButton.setTextFill(Color.BLACK); // 글자를 검은색으로
			TestButton.setStyle("-fx-background-color: blue"); // 버튼 배경색을 파랑색으로
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
