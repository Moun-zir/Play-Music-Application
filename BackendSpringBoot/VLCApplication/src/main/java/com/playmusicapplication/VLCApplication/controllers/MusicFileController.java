package com.playmusicapplication.VLCApplication.controllers;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.InvalidPathException;

@RestController
public class MusicFileController {

    private final String UPLOAD_DIR = "uploads"; // Chemin du dossier upload

    @GetMapping("/api/music/files/{filename}")
public ResponseEntity<Resource> serveFile(@PathVariable String filename) throws IOException {
    Path filePath = Paths.get(UPLOAD_DIR).resolve(filename).normalize();
    Resource resource = new UrlResource(filePath.toUri());

    if (!resource.exists() || !resource.isReadable()) {
        return ResponseEntity.notFound().build(); // Retourner 404 si le fichier n'existe pas
    }

    HttpHeaders headers = new HttpHeaders();
    headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + resource.getFilename());
    headers.add(HttpHeaders.CACHE_CONTROL, "no-cache, no-store, must-revalidate");
    headers.add(HttpHeaders.PRAGMA, "no-cache");
    headers.add(HttpHeaders.EXPIRES, "0");

    // Définir le type de contenu correct pour un fichier MP3
    String contentType = Files.probeContentType(filePath);
    if (contentType == null) {
        contentType = "audio/mpeg"; // Par défaut pour MP3
    }

    return ResponseEntity.ok()
            .headers(headers)
            .contentLength(filePath.toFile().length())
            .contentType(MediaType.parseMediaType(contentType))
            .body(resource);
}

}
