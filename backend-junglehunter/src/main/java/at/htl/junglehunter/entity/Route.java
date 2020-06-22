package at.htl.junglehunter.entity;

import at.htl.junglehunter.dto.RouteDto;
import io.quarkus.hibernate.orm.panache.PanacheEntity;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Entity
public class Route extends PanacheEntity {

    @Column(length = 100)
    public String name;

    @Column(length = 100)
    public String start;

    public String url;

    public String description;

    @OneToMany(mappedBy = "route", cascade = CascadeType.REMOVE)
    public List<Trail> trails;

    public Route(String name, String start, String url, String description) {
        this.name = name;
        this.start = start;
        this.url = url;
        this.description = description;
    }

    public Route() {
    }

    public void update(RouteDto route) {
        this.name = route.getName();
        this.start = route.getStart();
        this.url = route.getUrl();
        this.description = route.getDescription();
    }

    public static RouteDto getDto(Long id) {
        Route route = findById(id);
        return route == null ? null : RouteDto.map(route);
    }

    public static List<RouteDto> getDtos(Stream<Route> entityStream) {
        return entityStream
                .map(RouteDto::map)
                .collect(Collectors.toList());
    }

    public static List<RouteDto> getDtos() {
        return Route.getDtos(Route.streamAll());
    }
}
