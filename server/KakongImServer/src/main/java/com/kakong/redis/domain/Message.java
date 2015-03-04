package com.kakong.redis.domain;

public class Message implements NSObject {

	private static final long serialVersionUID = -1160140514411999084L;

	public static final String OBJECT_KEY = "MESSAGE";

	@Override
	public String getKey() {
		// TODO Auto-generated method stub
		return getCid();
	}

	@Override
	public String getObjectKey() {
		// TODO Auto-generated method stub
		return OBJECT_KEY;
	}

	/**
	 * 主键id
	 */
	private String cid;

	/**
	 * 发送放id
	 */
	private String uid;

	/**
	 * 接收方id
	 */
	private String toid;

	/**
	 * 聊天内容
	 */
	private String chart;

	/**
	 * 聊天图片
	 */
	private String pic;

	/**
	 * 聊天视频
	 */
	private String video;

	/**
	 * 聊天录音
	 */
	private String record;

	/**
	 * 发送时间
	 */
	private String time;

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getToid() {
		return toid;
	}

	public void setToid(String toid) {
		this.toid = toid;
	}

	public String getChart() {
		return chart;
	}

	public void setChart(String chart) {
		this.chart = chart;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public String getRecord() {
		return record;
	}

	public void setRecord(String record) {
		this.record = record;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
