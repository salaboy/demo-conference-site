package com.salaboy.conferences.site;

import com.salaboy.conferences.site.models.AgendaItem;
import com.salaboy.conferences.site.models.Proposal;
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

    @GetMapping("/info")
    public String infoWithVersion() {
        return "Site v" + version;
    }

    @GetMapping("/")
    public String index(Model model) {

        RestTemplate restTemplate = new RestTemplate();

        String conferenceC4P = "http://demo-conference-c4p";
        //String conferenceC4P = "http://demo-conference-c4p.jx-staging.35.198.168.7.nip.io/";
        String conferenceAgenda = "http://demo-conference-agenda";
        //String conferenceAgenda = "http://demo-conference-agenda.jx-staging.35.198.168.7.nip.io/";
        String agendaInfo = "N/A";
        String c4pInfo = "N/A";
        try {
            ResponseEntity<String> agenda = restTemplate.getForEntity(conferenceAgenda + "/info", String.class);
            agendaInfo = agenda.getBody();

        } catch (Exception e) {
        }
        try {
            ResponseEntity<String> sponsors = restTemplate.getForEntity(conferenceC4P + "/info", String.class);
            c4pInfo = sponsors.getBody();
        } catch (Exception e) {
        }

        ResponseEntity<List<AgendaItem>> agendaItems = null;

        try {
            agendaItems = restTemplate.exchange(conferenceAgenda, HttpMethod.GET, null, new ParameterizedTypeReference<List<AgendaItem>>() {
            });
        } catch (Exception e) {
        }

        ResponseEntity<List<Proposal>> proposals = null;

        try {
            proposals = restTemplate.exchange(conferenceC4P, HttpMethod.GET, null, new ParameterizedTypeReference<List<Proposal>>() {
            });
        } catch (Exception e) {
        }

        model.addAttribute("version", version);
        model.addAttribute("agenda", agendaInfo);
        model.addAttribute("c4pURL", conferenceC4P);
        model.addAttribute("agendaURL", conferenceAgenda);
        model.addAttribute("c4p", c4pInfo);

        if (agendaItems != null) {
            model.addAttribute("agendaItems", agendaItems.getBody());
        }

        if (proposals != null) {
            model.addAttribute("proposals", proposals.getBody());
        }
        return "index";
    }

}
