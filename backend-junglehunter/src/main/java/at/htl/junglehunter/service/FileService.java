package at.htl.junglehunter.service;

import at.htl.junglehunter.dto.FileDto;
import at.htl.junglehunter.entity.ControlPoint;
import at.htl.junglehunter.entity.Image;
import at.htl.junglehunter.entity.User;
import org.eclipse.microprofile.config.inject.ConfigProperty;

import javax.enterprise.context.ApplicationScoped;
import javax.transaction.Transactional;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
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

    @Transactional
    public void uploadImage(FileDto fileDto, ControlPoint controlPoint, User user) {
        Image image = new Image(controlPoint, user);
        image.persist();
        String filePath = Path.of(
                "image", String.valueOf(user.id), String.valueOf(controlPoint.id), String.valueOf(image.id)
        ).toString();
        this.uploadFile(fileDto, filePath);
    }
}
