CREATE MIGRATION m1z3r6lelgguvs76dlmtfzdhqwjba77lzcnp66hfoh6axglqdumdza
    ONTO initial
{
  CREATE GLOBAL default::current_collection_id -> std::uuid;
  CREATE GLOBAL default::current_collection_name -> std::str;
  CREATE TYPE default::DataBaseHub {
      CREATE PROPERTY name: std::str;
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (true);
      CREATE PROPERTY config: std::json;
      CREATE PROPERTY contentType: std::str;
      CREATE PROPERTY emb_model: std::str;
  };
  CREATE TYPE default::Chunk {
      CREATE MULTI LINK X_ref: default::Chunk {
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK database: default::DataBaseHub;
      CREATE PROPERTY content: std::str {
          SET default := '';
      };
      CREATE PROPERTY isEnabled: std::bool {
          SET default := false;
      };
      CREATE PROPERTY payload: std::json {
          SET default := (std::to_json('{}'));
      };
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE PROPERTY contentType: std::str;
      CREATE PROPERTY old_id: std::str;
  };
  CREATE TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE PROPERTY history: std::str;
  };
  CREATE TYPE default::Tag {
      CREATE PROPERTY name: std::str;
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::Chunk {
      CREATE MULTI LINK tags: default::Tag {
          ON TARGET DELETE ALLOW;
      };
  };
  CREATE TYPE default::Dashbord {
      CREATE MULTI LINK tags: default::Tag {
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY name: std::str {
          SET default := 'dashboard';
      };
      CREATE MULTI LINK chats: default::Chat {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE PROPERTY description: std::str {
          SET default := 'Dashboard';
      };
  };
  CREATE TYPE default::File {
      CREATE MULTI LINK chunks: default::Chunk {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY path: std::str;
      CREATE PROPERTY isEnabled: std::bool {
          SET default := true;
      };
      CREATE TRIGGER update_is_enable_chunks
          AFTER UPDATE 
          FOR EACH 
              WHEN ((__new__.isEnabled != __old__.isEnabled))
          DO (UPDATE
              __old__.chunks
          SET {
              isEnabled := __new__.isEnabled
          });
      CREATE LINK file: default::Chunk {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE PROPERTY description: std::str;
  };
  CREATE TYPE default::Folder {
      CREATE MULTI LINK files: default::File {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY isEnabled: std::bool {
          SET default := true;
      };
      CREATE TRIGGER update_is_enable_files
          AFTER UPDATE 
          FOR EACH 
              WHEN ((__new__.isEnabled != __old__.isEnabled))
          DO (UPDATE
              __old__.files
          SET {
              isEnabled := __new__.isEnabled
          });
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE MULTI LINK folders: default::Folder {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY description: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY path: std::str;
  };
  CREATE TYPE default::Prompt {
      CREATE MULTI LINK X_dashbord: default::Dashbord {
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK X_file: default::File {
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK X_folder: default::Folder {
          ON TARGET DELETE ALLOW;
      };
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
      CREATE MULTI LINK X_prompt: default::Prompt {
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK X_tag: default::Tag {
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY content: std::str;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY metadata: std::json;
      CREATE PROPERTY name: std::str;
      CREATE PROPERTY tags: std::str;
  };
  CREATE TYPE default::Collection {
      CREATE MULTI LINK chunks: default::Chunk {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK dashbord: default::Dashbord {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK files: default::File {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK tags: default::Tag {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE MULTI LINK chats: default::Chat {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK databases: default::DataBaseHub {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK folders: default::Folder {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK prompts: default::Prompt {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY metadata: std::json;
  };
  CREATE FUNCTION default::parse_chunks(data: default::Chunk) ->  std::json USING (SELECT
      <std::json>(SELECT
          data {
              ID := data.id,
              payload := (<std::json>(
                  pageContent := (data.content ?? ''),
                  system_metadata := {
                      dashboard_on := DISTINCT (data.tags.<tags[IS default::Dashbord].name),
                      database_name := data.database.name,
                      tags_name := data.tags.name,
                      X_ID := data.X_ref.id,
                      as_X_ID := data.<X_ref[IS default::Chunk].id,
                      path := (SELECT
                          DISTINCT (data.<chunks[IS default::File].path) 
                      LIMIT
                          1
                      ),
                      filename := (SELECT
                          DISTINCT (data.<chunks[IS default::File].name) 
                      LIMIT
                          1
                      ),
                      isEnabled := data.isEnabled
                  },
                  metadata := data.payload
              ) ?? std::to_json('{}'))
          }
      )
  );
  ALTER TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chats[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chats[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chats[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chats[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chats[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chats[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              chats += __new__
          });
  };
  ALTER TYPE default::Chunk {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chunks[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chunks[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chunks[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chunks[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chunks[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chunks[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              chunks += __new__
          });
  };
  ALTER TYPE default::Dashbord {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<dashbord[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<dashbord[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<dashbord[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<dashbord[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<dashbord[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<dashbord[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              dashbord += __new__
          });
  };
  ALTER TYPE default::DataBaseHub {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<databases[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<databases[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<databases[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<databases[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              databases += __new__
          });
  };
  ALTER TYPE default::File {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<files[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<files[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<files[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<files[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<files[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<files[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              files += __new__
          });
  };
  ALTER TYPE default::Folder {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<folders[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<folders[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<folders[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<folders[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<folders[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<folders[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              folders += __new__
          });
  };
  ALTER TYPE default::Prompt {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<prompts[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<prompts[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<prompts[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<prompts[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<prompts[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<prompts[IS default::Collection].name))));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              prompts += __new__
          });
  };
  ALTER TYPE default::Tag {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<tags[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<tags[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<tags[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<tags[IS default::Collection].name))));
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<tags[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<tags[IS default::Collection].name))));
      CREATE MULTI LINK chunks := (.<tags[IS default::Chunk]);
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              tags += __new__
          });
  };
};
