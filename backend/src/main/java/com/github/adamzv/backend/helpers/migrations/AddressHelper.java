package com.github.adamzv.backend.helpers.migrations;

import com.github.adamzv.backend.model.Address;
import com.github.adamzv.backend.model.Container;
import com.github.adamzv.backend.model.Town;
import org.flywaydb.core.api.migration.Context;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

public class AddressHelper {

    private final Context context;

    public AddressHelper(Context context) {
        this.context = context;
    }

    public List<Container> saveAll(List<Container> containers) throws Exception {
        for (Container containerNew : containers) {
            containerNew.setAddress(findUniqueAddress(containerNew.getAddress()));
        }
        return containers;
    }

    private Address findUniqueAddress(Address addressNew) throws Exception {
        try (Statement select = context.getConnection().createStatement()) {

            // find out if address already exits
            try (ResultSet rows = select.executeQuery("SELECT * FROM address WHERE address.address = '" + addressNew.getAddress() + "'")) {
                Address address = new Address();
                while (rows.next()) {
                    address.setId(rows.getLong(1));
                    address.setAddress(rows.getString(2));

                    // create town object with id and insert it into the address
                    Town town = new Town();
                    town.setId(rows.getLong(3));
                    address.setTown(town);
                }

                // if address exists, return it. Otherwise save new address and return that
                if (address.getId() != null) {
                    return address;
                } else {
                    return saveAddress(addressNew);
                }
            }
        }
    }

    private Address saveAddress(Address addressNew) throws Exception {
        try (Statement update = context.getConnection().createStatement()) {
            update.execute("INSERT INTO address VALUES (" + addressNew.getId() + ", '"
                    + addressNew.getAddress() + "', " + addressNew.getTown().getId() + " )", Statement.RETURN_GENERATED_KEYS);

            // we need to add id of newly created address to the object
            ResultSet rs = update.getGeneratedKeys();
            rs.next();
            addressNew.setId(rs.getLong(1));
            return addressNew;
        }
    }
}
