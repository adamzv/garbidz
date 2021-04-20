package com.github.adamzv.backend.helpers.migrations;

import com.github.adamzv.backend.model.Container;
import org.flywaydb.core.api.migration.Context;

import java.sql.Statement;
import java.util.List;

public class ContainerHelper {

    private final Context context;

    public ContainerHelper(Context context) {
        this.context = context;
    }

    public void saveAll(List<Container> containers) throws Exception {
        for (Container containerNew : containers) {
            try (Statement update = context.getConnection().createStatement()) {

                // insert new container into db
                update.execute("INSERT INTO container VALUES (" + containerNew.getId() + ", "
                        + containerNew.getAddress().getId() + ", " + containerNew.getType().getId() + ", '"
                        + containerNew.getGarbageType() + "' )");
            }
        }
    }
}