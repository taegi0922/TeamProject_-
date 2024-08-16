package com.medicalInfo.project.model;

import java.util.List; 

public class MedicineResponse {
    private Header header;
    private Body body;

    // Getters and setters
    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }

    public Body getBody() {
        return body;
    }

    public void setBody(Body body) {
        this.body = body;
    }

    public static class Header {
        private String resultCode;
        private String resultMsg;

        // Getters and setters
        public String getResultCode() {
            return resultCode;
        }

        public void setResultCode(String resultCode) {
            this.resultCode = resultCode;
        }

        public String getResultMsg() {
            return resultMsg;
        }

        public void setResultMsg(String resultMsg) {
            this.resultMsg = resultMsg;
        }
    }

    public static class Body {
        private String pageNo;
        private String totalCount;
        private String numOfRows;
        private List<Item> items;

        // Getters and setters
        public String getPageNo() {
            return pageNo;
        }

        public void setPageNo(String pageNo) {
            this.pageNo = pageNo;
        }

        public String getTotalCount() {
            return totalCount;
        }

        public void setTotalCount(String totalCount) {
            this.totalCount = totalCount;
        }

        public String getNumOfRows() {
            return numOfRows;
        }

        public void setNumOfRows(String numOfRows) {
            this.numOfRows = numOfRows;
        }

        public List<Item> getItems() {
            return items;
        }

        public void setItems(List<Item> items) {
            this.items = items;
        }
    }

    public static class Item {
        private String entpName;
        private String itemName;
        private String itemSeq;
        private String efcyQesitm;
        private String useMethodQesitm;
        private String atpnWarnQesitm;
        private String atpnQesitm;
        private String intrcQesitm;
        private String seQesitm;
        private String depositMethodQesitm;
        private String openDe;
        private String updateDe;
        private String itemImage;
        private String bizrno;

        // Getters and setters
        public String getEntpName() {
            return entpName;
        }

        public void setEntpName(String entpName) {
            this.entpName = entpName;
        }

        public String getItemName() {
            return itemName;
        }

        public void setItemName(String itemName) {
            this.itemName = itemName;
        }

        public String getItemSeq() {
            return itemSeq;
        }

        public void setItemSeq(String itemSeq) {
            this.itemSeq = itemSeq;
        }

        public String getEfcyQesitm() {
            return efcyQesitm;
        }

        public void setEfcyQesitm(String efcyQesitm) {
            this.efcyQesitm = efcyQesitm;
        }

        public String getUseMethodQesitm() {
            return useMethodQesitm;
        }

        public void setUseMethodQesitm(String useMethodQesitm) {
            this.useMethodQesitm = useMethodQesitm;
        }

        public String getAtpnWarnQesitm() {
            return atpnWarnQesitm;
        }

        public void setAtpnWarnQesitm(String atpnWarnQesitm) {
            this.atpnWarnQesitm = atpnWarnQesitm;
        }

        public String getAtpnQesitm() {
            return atpnQesitm;
        }

        public void setAtpnQesitm(String atpnQesitm) {
            this.atpnQesitm = atpnQesitm;
        }

        public String getIntrcQesitm() {
            return intrcQesitm;
        }

        public void setIntrcQesitm(String intrcQesitm) {
            this.intrcQesitm = intrcQesitm;
        }

        public String getSeQesitm() {
            return seQesitm;
        }

        public void setSeQesitm(String seQesitm) {
            this.seQesitm = seQesitm;
        }

        public String getDepositMethodQesitm() {
            return depositMethodQesitm;
        }

        public void setDepositMethodQesitm(String depositMethodQesitm) {
            this.depositMethodQesitm = depositMethodQesitm;
        }

        public String getOpenDe() {
            return openDe;
        }

        public void setOpenDe(String openDe) {
            this.openDe = openDe;
        }

        public String getUpdateDe() {
            return updateDe;
        }

        public void setUpdateDe(String updateDe) {
            this.updateDe = updateDe;
        }

        public String getItemImage() {
            return itemImage;
        }

        public void setItemImage(String itemImage) {
            this.itemImage = itemImage;
        }

        public String getBizrno() {
            return bizrno;
        }

        public void setBizrno(String bizrno) {
            this.bizrno = bizrno;
        }
    }
}