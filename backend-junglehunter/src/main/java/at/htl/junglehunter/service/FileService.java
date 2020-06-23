package at.htl.junglehunter.service;

import at.htl.junglehunter.dto.FileDto;
import org.eclipse.microprofile.config.inject.ConfigProperty;

import javax.enterprise.context.ApplicationScoped;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@ApplicationScoped
public class FileService {

    @ConfigProperty(name = "junglehunter.image-path")
    String path;

    public boolean uploadFile(FileDto fileDto, String filePath) {
        File file = new File(this.path + "/" + filePath);
        file.getParentFile().mkdirs();
        try {
            Files.write(file.toPath(), fileDto.getData());
            return true;
        } catch (IOException ignored) {
            return false;
        }
    }

    public boolean deleteFile(String filePath) {
        try {
            return Files.deleteIfExists(Paths.get(this.path + "/" + filePath));
        } catch (IOException ignored) {
            return false;
        }
    }
}
