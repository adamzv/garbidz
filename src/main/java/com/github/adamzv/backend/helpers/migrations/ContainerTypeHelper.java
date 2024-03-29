package com.github.adamzv.backend.helpers.migrations;

import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.model.ContainerType;
import org.flywaydb.core.api.migration.Context;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

public class ContainerTypeHelper {

    private final Context context;

    public ContainerTypeHelper(Context context) {
        this.context = context;
    }

    public List<Container> saveAll(List<Container> containers) throws Exception {
        for (Container containerNew : containers) {
            containerNew.setType(findUniqueType(containerNew.getType()));
        }
        return containers;
    }

    private ContainerType findUniqueType(ContainerType containerTypeNew) throws Exception {
        try (Statement select = context.getConnection().createStatement()) {

            // find out if container type already exits
            try (ResultSet rows = select.executeQuery("SELECT * FROM container_type WHERE container_type.type = '" + containerTypeNew.getType() + "'")) {
                ContainerType containerType = new ContainerType();
                while (rows.next()) {
                    containerType.setId(rows.getLong(1));
                    containerType.setType(rows.getString(2));
                }
                if (containerType.getId() != null) {
                    return containerType;
                } else {
                    return saveContainerType(containerTypeNew);
                }
            }
        }
    }

    private ContainerType saveContainerType(ContainerType containerTypeNew) throws Exception {
        try (Statement update = context.getConnection().createStatement()) {
            update.execute("INSERT INTO container_type VALUES (" + containerTypeNew.getId() + ", '" + containerTypeNew.getType() + "')", Statement.RETURN_GENERATED_KEYS);

            // we need to add id of newly created container type to the object
            ResultSet rs = update.getGeneratedKeys();
            rs.next();
            containerTypeNew.setId(rs.getLong(1));
            return containerTypeNew;
        }
    }
}
