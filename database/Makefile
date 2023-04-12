DB=gixsql
BUILD=$(CURDIR)/build.sql
SCRIPTS=$(CURDIR)/scripts
CREATE=$(SCRIPTS)/create.sql
INSERT = $(SCRIPTS)/insert.sql
DROP = $(SCRIPTS)/drop.sql

.PHONY: drop clean

all: insert
	psql $(DB) -f $(BUILD)

create:
	@cat $(CREATE) >> $(BUILD)

insert: create
	@cat $(INSERT) >> $(BUILD)

drop:
	psql $(DB) -f $(DROP)

clean:
	@rm -rf $(BUILD)
