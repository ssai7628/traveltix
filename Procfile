/*
 * TravelTix Fare Microservice
 * Deployed by: Saikrishnan S
 *
 * A small, dependency-free Java HTTP service that calculates ticket fares
 * and generates unique ticket IDs for the Python backend to consume.
 *
 * Endpoints:
 *   GET  /api/health           -> {"status":"ok","service":"java-fare-service"}
 *   POST /api/fare             -> body: {"distanceKm":350,"mode":"bus","seats":2}
 *                                  resp: {"fare":1750.0,"ticketId":"TT-AB12CD34"}
 *
 * Build & run locally:
 *   javac TicketService.java
 *   java TicketService
 *
 * Listens on $PORT if set (Render/Railway provide this), else 8080.
 */

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TicketService {

    // Per-km fare rates by transport mode
    private static final double BUS_RATE = 2.5;
    private static final double TRAIN_RATE = 1.8;

    public static void main(String[] args) throws IOException {
        int port = Integer.parseInt(System.getenv().getOrDefault("PORT", "8080"));
        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);

        server.createContext("/api/health", new HealthHandler());
        server.createContext("/api/fare", new FareHandler());

        server.setExecutor(null); // default executor
        server.start();
        System.out.println("TravelTix Java fare service running on port " + port);
    }

    static class HealthHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String body = "{\"status\":\"ok\",\"service\":\"java-fare-service\"}";
            sendJson(exchange, 200, body);
        }
    }

    static class FareHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            if (!"POST".equalsIgnoreCase(exchange.getRequestMethod())) {
                sendJson(exchange, 405, "{\"error\":\"Method Not Allowed\"}");
                return;
            }

            String requestBody = readBody(exchange.getRequestBody());

            int distanceKm = extractInt(requestBody, "distanceKm", 0);
            String mode = extractString(requestBody, "mode", "bus");
            int seats = extractInt(requestBody, "seats", 1);

            if (distanceKm <= 0 || seats <= 0) {
                sendJson(exchange, 400, "{\"error\":\"Invalid distanceKm or seats\"}");
                return;
            }

            double rate = "train".equalsIgnoreCase(mode) ? TRAIN_RATE : BUS_RATE;
            double fare = Math.round(distanceKm * rate * seats * 100.0) / 100.0;
            String ticketId = "TT-" + UUID.randomUUID().toString()
                    .replace("-", "").substring(0, 8).toUpperCase();

            String response = String.format(
                    "{\"fare\":%s,\"ticketId\":\"%s\"}", fare, ticketId);
            sendJson(exchange, 200, response);
        }
    }

    // ---------------------------------------------------------- Utilities --

    private static String readBody(InputStream is) throws IOException {
        StringBuilder sb = new StringBuilder();
        byte[] buf = new byte[1024];
        int read;
        while ((read = is.read(buf)) != -1) {
            sb.append(new String(buf, 0, read, StandardCharsets.UTF_8));
        }
        return sb.toString();
    }

    private static int extractInt(String json, String key, int fallback) {
        Pattern p = Pattern.compile("\"" + key + "\"\\s*:\\s*(-?\\d+)");
        Matcher m = p.matcher(json);
        return m.find() ? Integer.parseInt(m.group(1)) : fallback;
    }

    private static String extractString(String json, String key, String fallback) {
        Pattern p = Pattern.compile("\"" + key + "\"\\s*:\\s*\"([^\"]*)\"");
        Matcher m = p.matcher(json);
        return m.find() ? m.group(1) : fallback;
    }

    private static void sendJson(HttpExchange exchange, int status, String body) throws IOException {
        byte[] bytes = body.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", "application/json");
        exchange.sendResponseHeaders(status, bytes.length);
        OutputStream os = exchange.getResponseBody();
        os.write(bytes);
        os.close();
    }
}
