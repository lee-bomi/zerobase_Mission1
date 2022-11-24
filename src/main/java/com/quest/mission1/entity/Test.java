package com.quest.mission1.entity;

import lombok.Data;

@Data
public class Test {
    int id;
    String name;

    public Test(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Test() {
    }
}
