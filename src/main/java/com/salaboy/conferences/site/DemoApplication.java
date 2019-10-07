package com.salaboy.conferences.site;

import com.salaboy.conferences.site.models.AgendaItem;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@SpringBootApplication
public class DemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }


}

@Controller
class ConferenceSiteController {
    @Value("${version:0}")
    private String version;


    @GetMapping("/")
    public String index(Model model) {

        RestTemplate restTemplate = new RestTemplate();

        String conferenceC4PInfo = "http://demo-conference-c4p/info";
        String conferenceAgendaInfo = "http://demo-conference-agenda.jx-staging.35.198.168.7.nip.io/info";//"http://demo-conference-agenda/info";
        String conferenceAgendaItems = "http://demo-conference-agenda.jx-staging.35.198.168.7.nip.io";
        String agendaString = "N/A";
        String c4pString = "N/A";
        try {
            ResponseEntity<String> agenda = restTemplate.getForEntity(conferenceAgendaInfo, String.class);
            agendaString = agenda.getBody();

        } catch (Exception e) {
        }
        try {
            ResponseEntity<String> sponsors = restTemplate.getForEntity(conferenceC4PInfo, String.class);
            c4pString = sponsors.getBody();
        } catch (Exception e) {
        }


        ResponseEntity<List<AgendaItem>> agendaItems = null;

        try {
            agendaItems = restTemplate.exchange(conferenceAgendaItems, HttpMethod.GET, null, new ParameterizedTypeReference<List<AgendaItem>>() {});
        } catch (Exception e) {
        }

        model.addAttribute("version", version);
        model.addAttribute("agenda", agendaString);
        model.addAttribute("c4p", c4pString);
        if (agendaItems != null) {
            model.addAttribute("agendaItems", agendaItems.getBody());
        }
        return "index";
    }

}
