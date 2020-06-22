package at.htl.junglehunter.dto;

import at.htl.junglehunter.entity.Route;
import at.htl.junglehunter.entity.Trail;
import at.htl.junglehunter.validaton.Checks;
import at.htl.junglehunter.validaton.Unique;
import org.hibernate.validator.constraints.Length;

import javax.validation.GroupSequence;
import javax.validation.constraints.NotBlank;
import java.util.LinkedList;
import java.util.List;

@GroupSequence({RouteDto.class, Checks.Unique.class})
public class RouteDto {

    private Long id;

    @NotBlank
    @Length(min = 1, max = 100)
    @Unique(entity = Route.class, field = "name", groups = Checks.Unique.class)
    private String name;

    @NotBlank
    @Length(min = 1, max = 100)
    private String start;

    @NotBlank
    @Length(min = 1, max = 255)
    private String url;

    @NotBlank
    @Length(min = 1, max = 255)
    private String description;

    private List<TrailDto> trails = new LinkedList<>();

    public RouteDto(Long id, String name, String start, String url, String description, List<TrailDto> trails) {
        this.id = id;
        this.name = name;
        this.start = start;
        this.url = url;
        this.description = description;
        this.trails = trails;
    }

    public RouteDto() {
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name.trim();
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description.trim();
    }

    public List<TrailDto> getTrails() {
        return trails;
    }

    public Route map() {
        return new Route(this.name, this.start, this.url, this.description);
    }

    public static RouteDto map(Route route) {
        return new RouteDto(
                route.id,
                route.name,
                route.start,
                route.url,
                route.description,
                Trail.getDtos(route.trails.stream())
        );
    }
}
