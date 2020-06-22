package at.htl.junglehunter.dto;

import org.jboss.resteasy.annotations.providers.multipart.PartType;

import javax.ws.rs.FormParam;

public class FileDto {

    private byte[] data;

    public byte[] getData() {
        return data;
    }

    @FormParam("file")
    @PartType("application/octet-stream")
    public void setData(byte[] data) {
        this.data = data;
    }
}
