package at.htl.junglehunter.entity;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

@Entity
public class Image extends PanacheEntity {

    @ManyToOne
    public ControlPoint controlPoint;

    @ManyToOne
    public User user;

    public Image(ControlPoint controlPoint, User user) {
        this.controlPoint = controlPoint;
        this.user = user;
    }

    public Image() {
    }
}
