package at.htl.junglehunter.model;

public class FailedField {
    private String key;
    private String value;
    private String message;

    public FailedField(String key, String value, String message) {
        this.key = key;
        this.value = value;
        this.message = message;
    }

    public FailedField() {
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
