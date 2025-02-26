package com.playmusicapplication.VLCApplication.services;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Service
public class FileStorageServiceImpl implements FileStorageService {

    private final Path uploadDirectory = Paths.get("uploads").toAbsolutePath().normalize();

    public FileStorageServiceImpl() {
        try {
            Files.createDirectories(uploadDirectory);
        } catch (IOException ex) {
            throw new RuntimeException("Impossible de créer le dossier de stockage", ex);
        }
    }

    @Override
    public String storeFile(MultipartFile file) {
        try {
            String originalFileName = file.getOriginalFilename();
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String newFileName = UUID.randomUUID().toString() + fileExtension;
            Path targetPath = uploadDirectory.resolve(newFileName);
            file.transferTo(targetPath.toFile());
            return targetPath.toString();
        } catch (IOException ex) {
            throw new RuntimeException("Erreur lors du stockage du fichier " + file.getOriginalFilename(), ex);
        }
    }
}
