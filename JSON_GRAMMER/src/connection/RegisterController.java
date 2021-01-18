package application;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.GridPane;

public class RegisterController {

	//RegisterBasic
	@FXML
	private AnchorPane basicAnchorPane;
	@FXML
	private TextField titleTextField;
	@FXML
	private TextField locationTextField;
	@FXML
	private DatePicker scheduleDatePicker;
	@FXML
	private ComboBox<String> timeCobmobox;
	@FXML
	private ComboBox<String> fontSizeComboBox;
	@FXML
	private Button registerButton;
	@FXML
	private Button cancelButton;
	@FXML
	private Button extensionButton;
	
	//RegisterExtension
	@FXML
	private AnchorPane extensionAnchorPane;
	@FXML
    private TextField exTitleTextField;
    @FXML
    private TextField exLocationTextField;
    @FXML
    private DatePicker exScheduleDatePicker;
    @FXML
    private ComboBox<String> exTimeCobmobox;
    @FXML
    private ComboBox<String> exFontSizeComboBox;
    @FXML
    private RadioButton exAlramUseButton;
    @FXML
    private RadioButton exAlramUnuseButton;
    @FXML
    private RadioButton exLunarUseButton;
    @FXML
    private RadioButton exLunarUnuseButton;
    @FXML
    private RadioButton exRepeatUseButton;
    @FXML
    private RadioButton exRepeatUnuseButton;
    @FXML
    private Button exBasicButton;
    @FXML
    private Label exAlarmTimeLabel;
    @FXML
    private ComboBox<String> exAlarmTimeComboBox;
    @FXML
    private ComboBox<String> exRepeatDateComboBox;
    @FXML
    private Button exStickerButton;
    @FXML
    private Button exStickerUnuseButton;
    @FXML
    private GridPane exStickerGridPane;
    @FXML
    private Label stickerPathLabel;
    @FXML
    private Button moneySticker;
    @FXML
    private Button travelSticker;
    @FXML
    private Button classSticker;
    @FXML
    private Button hospitalSticker;
    @FXML
    private Button dishSticker;
    @FXML
    private Button meetingSticker;
    @FXML
    private Button exerciseSticker;
    @FXML
    private Button dateSticker;
    @FXML
    private Button importantSticker;
	
    //폰트 콤보박스에 리스트 지정
    ObservableList<String> fontSizeComboBoxList = FXCollections.observableArrayList("1","2","3","4","5");
    //시간 콤보박스에 리스트 지정
    ObservableList<String> timeComboBoxList = FXCollections.observableArrayList("오전 08:00~09:00","오전 09:00~10:00","오전 10:00~11:00","오전 11:00~12:00","오후 12:00~01:00","오후 01:00~02:00","오후 02:00~03:00","오후 03:00~04:00","오후 04:00~05:00","오후 05:00~06:00","오후 06:00~07:00","오후 07:00~08:00","오후 08:00~09:00","오후 09:00~10:00","오후 11:00~12:00","오전 00:00~01:00","오전 01:00~02:00","오전 02:00~03:00","오전 03:00~04:00","오전 04:00~05:00","오전 05:00~06:00","오전 06:00~07:00","오전 07:00~08:00");
    //알람시간 콤보박스에 리스트 지정
    ObservableList<String> exAlarmTimeComboBoxList = FXCollections.observableArrayList("일정시작시간","10분 전","1시간 전","1일 전");
    //반복날짜 콤보박스에 리스트 지정
    ObservableList<String> exRepeatDateComboBoxList = FXCollections.observableArrayList("매일","매주","매달");

    
	public void initialize() {
		//font size 기본값 지정
		fontSizeComboBox.setValue("3");
		fontSizeComboBox.setItems(fontSizeComboBoxList);
		exFontSizeComboBox.setValue("3");
		exFontSizeComboBox.setItems(fontSizeComboBoxList);
		timeCobmobox.setValue("오전 08:00~09:00");
		timeCobmobox.setItems(timeComboBoxList);
		exTimeCobmobox.setValue("오전 08:00~09:00");
		exTimeCobmobox.setItems(timeComboBoxList);
		exAlarmTimeComboBox.setItems(exAlarmTimeComboBoxList);
		exRepeatDateComboBox.setItems(exRepeatDateComboBoxList);
		
	}
	
	public void extension() {
		exTitleTextField.setText(titleTextField.getText());
		exFontSizeComboBox.setValue(fontSizeComboBox.getValue());
		exTimeCobmobox.setValue(timeCobmobox.getValue());
		extensionAnchorPane.setVisible(true);
		basicAnchorPane.setVisible(false);
		exScheduleDatePicker.setValue(scheduleDatePicker.getValue());
		exLocationTextField.setText(locationTextField.getText());
	}
	
	public void basic() {
		titleTextField.setText(exTitleTextField.getText());
		fontSizeComboBox.setValue(exFontSizeComboBox.getValue());
		timeCobmobox.setValue(exTimeCobmobox.getValue());
		basicAnchorPane.setVisible(true);
		extensionAnchorPane.setVisible(false);
		scheduleDatePicker.setValue(exScheduleDatePicker.getValue());
		locationTextField.setText(exLocationTextField.getText());
	}
	
	public void AlarmTimeUse() {
		exAlarmTimeLabel.setVisible(true);
		exAlarmTimeComboBox.setVisible(true);
		exAlarmTimeComboBox.setValue("10분 전");
	}
	
	public void AlarmTimeUnuse() {
		exAlarmTimeLabel.setVisible(false);
		exAlarmTimeComboBox.setVisible(false);
		exAlarmTimeComboBox.setValue("");
	}
	
	public void RepeatDateUse() {
		exRepeatDateComboBox.setVisible(true);
		exRepeatDateComboBox.setValue("매주");
	}
	
	public void RepeatDateUnuse() {
		exRepeatDateComboBox.setVisible(false);
		exRepeatDateComboBox.setValue("");
	}
	
	public void stickerButton() {
		exStickerGridPane.setVisible(!exStickerGridPane.isVisible());
	}
	
	public void stickerClicked(ActionEvent event) {
		String tmp = event.getSource().toString();
		String str = tmp.substring(10, 14);
		switch(str) {
			case "impo": stickerPathLabel.setText("importantSticker"); break;
			case "mone": stickerPathLabel.setText("moneySticker"); break;
			case "trav": stickerPathLabel.setText("travelSticker"); break;
			case "clas": stickerPathLabel.setText("classSticker"); break;
			case "hosp": stickerPathLabel.setText("hospitalSticker"); break;
			case "exer": stickerPathLabel.setText("exerciseSticker"); break;
			case "dish": stickerPathLabel.setText("dishSticker"); break;
			case "meet": stickerPathLabel.setText("meetingSticker"); break;
			case "date": stickerPathLabel.setText("dateSticker"); break;
		}
		
	}
	
	public void stickerUnuseButton() {
		stickerPathLabel.setText("");
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void registerSchedule() {
		
		//수정필요
		String member_id = "user03";
		
		Random random = new Random();
		int randomNum = random.nextInt(1000000); //100만개의 일정을 만들 수 있음
		int empty = 6 - ((int)Math.log10(randomNum)+1);
		
		JSONParser parser = new JSONParser();
		File scheduleJson = new File(".\\jsonFile\\schedule.json");
		FileReader fr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		BufferedWriter bw = null;
		
		String schedule_id = "";
		
		createScheduleId : while(true) {
			
			switch(empty) {
			case 0: schedule_id = Integer.toString(randomNum); break;
			case 1: schedule_id = "0"+randomNum; break;
			case 2: schedule_id = "00"+randomNum; break;
			case 3: schedule_id = "000"+randomNum; break;
			case 4: schedule_id = "0000"+randomNum; break;
			case 5: schedule_id = "00000"+randomNum; break;
			}
			System.out.println(schedule_id);
			
			try {
				fr = new FileReader(scheduleJson);
				br = new BufferedReader(fr);
				JSONObject jsonObject = (JSONObject) parser.parse(br);
				JSONArray userArr = (JSONArray) jsonObject.get(member_id);
				
				for(int i = 0; i < userArr.size(); i++) {
					JSONObject jobj = (JSONObject) parser.parse(userArr.get(i).toString());
					if(jobj.containsValue(schedule_id)) {
						continue createScheduleId;
					}
					
				} break;
				
			} catch(Exception e) {
				System.out.println("createScheduleId: "+ e.getMessage());
				e.printStackTrace();
			} finally {
				if(null != br) {
					try {
						br.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		
		
		
		try {
			
			fr = new FileReader(scheduleJson);
			br = new BufferedReader(fr);
			
			JSONObject jsonObject = (JSONObject) parser.parse(br);
			
			fw = new FileWriter(scheduleJson);
			bw = new BufferedWriter(fw);	
			
			//초기화
			int text_size = 0;
			String schedule_title = "";
			String schedule_date = "";
			String schedule_time = "";
			String schedule_place = "";
			boolean schedule_alarm = false;
			String alarm_time = "";
			boolean lunar_date = false;
			boolean repeat_check = false;
			String repeat_type = "";
			String sticker_img = "";
			String register_date = LocalDate.now().toString();
			
			if(basicAnchorPane.isVisible()) {

				text_size = Integer.parseInt(fontSizeComboBox.getValue());
				schedule_title = titleTextField.getText();
				schedule_date = scheduleDatePicker.getValue().toString();
				schedule_time = timeCobmobox.getValue();
				schedule_place = locationTextField.getText();
				schedule_alarm = false;
				alarm_time = "";
				lunar_date = false;
				repeat_check = false;
				repeat_type = "";
				sticker_img = "";
				
				
				
			} else if(extensionAnchorPane.isVisible()) {
				text_size = Integer.parseInt(exFontSizeComboBox.getValue());
				schedule_title = exTitleTextField.getText();
				schedule_date = exScheduleDatePicker.getValue().toString();
				schedule_time = exTimeCobmobox.getValue();
				schedule_place = exLocationTextField.getText();
				schedule_alarm = exAlramUseButton.isSelected();
				alarm_time = exAlarmTimeComboBox.getValue();
				lunar_date = exLunarUseButton.isSelected();
				repeat_check = exRepeatUseButton.isSelected();
				repeat_type = exRepeatDateComboBox.getValue();
				sticker_img = stickerPathLabel.getText();
				
			}
			
			JSONArray userArr = (JSONArray) jsonObject.get(member_id);
			HashMap hm = new HashMap();
			hm.put("schedule_id", schedule_id);
			hm.put("text_size", text_size);
			hm.put("schedule_title", schedule_title);
			hm.put("schedule_date", schedule_date);
			hm.put("schedule_time", schedule_time);
			hm.put("schedule_place", schedule_place);
			hm.put("schedule_alarm", schedule_alarm);
			hm.put("alarm_time", alarm_time);
			hm.put("lunar_date", lunar_date);
			hm.put("repeat_check", repeat_check);
			hm.put("repeat_type", repeat_type);
			hm.put("sticker_img", sticker_img);
			hm.put("register_date", register_date);
			hm.put("member_id", member_id);
			userArr.add(hm);
			
			bw.write(jsonObject.toJSONString());
			
		} catch(Exception e) {
			System.out.println("registerSchedule: "+ e.getMessage());
			e.printStackTrace();
		} finally {
			if(null != br) {
				try {
					br.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(null != bw) {
				try {
					bw.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}//--finally
			
	}
	
	
	
	
	
	
}
