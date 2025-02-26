package com.playmusicapplication.VLCApplication.services;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.util.UUID;
import org.springframework.web.multipart.MultipartFile;

public interface FileStorageService {

    // Ce champ est implicitement public, static et final
    Path UPLOAD_DIRECTORY = Paths.get("C:/Users/mourchid.assani/Documents/dev_projets/FullStack/Play-Music-Application/backendSpringBoot/Vlcapplication/uploads");

    // Pour fournir une implémentation par défaut, on utilise le mot-clé default
    default String storeFile(MultipartFile file) {
        try {
            if (!Files.exists(UPLOAD_DIRECTORY)) {
                Files.createDirectories(UPLOAD_DIRECTORY);
            }
    
            String originalFileName = file.getOriginalFilename();
            if (originalFileName == null) {
                throw new RuntimeException("Nom de fichier invalide");
            }
            
            Path targetPath = UPLOAD_DIRECTORY.resolve(originalFileName);
            int i = 1;
            while (Files.exists(targetPath)) {
                // Ajoute un suffixe avant l'extension
                String baseName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
                String newFileName = baseName + "(" + i++ + ")" + extension;
                targetPath = UPLOAD_DIRECTORY.resolve(newFileName);
            }
    
            file.transferTo(targetPath.toFile());
            return targetPath.toString();
        } catch (IOException ex) {
            throw new RuntimeException("Erreur lors du stockage du fichier " + file.getOriginalFilename(), ex);
        }
    }
}
