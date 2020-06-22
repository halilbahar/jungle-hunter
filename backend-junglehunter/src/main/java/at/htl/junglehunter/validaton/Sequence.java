package at.htl.junglehunter.validaton;

import javax.validation.GroupSequence;

public interface Sequence {
    @GroupSequence({Checks.First.class, Checks.Second.class, Checks.Third.class})
    interface Route {
    }
}
