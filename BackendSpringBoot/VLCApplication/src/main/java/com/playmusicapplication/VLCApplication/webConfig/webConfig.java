package com.playmusicapplication.VLCApplication.webConfig;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**") // Autorise les requêtes vers les API
                .allowedOrigins("*") // Autoriser Flutter à accéder depuis le port 3000 (ou l'URL de votre app Flutter)
                .allowedMethods("GET", "POST", "PUT", "DELETE") // Méthodes autorisées
                .allowedHeaders("*"); // Autoriser tous les en-têtes
    }
}
