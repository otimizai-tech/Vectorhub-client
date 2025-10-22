CREATE MIGRATION m1k4ltmofrbaq4vu3644kncctp7a5fpw2rocmbzimf3mbdnfqqqlma
    ONTO m1izljfzeawvsjgambolbleb23tlejza2o46krbfghdwinmdh2n72q
{
  CREATE EXTENSION pgcrypto VERSION '1.3';
  CREATE TYPE default::Alias_name {
      CREATE REQUIRED LINK collection: default::Collection {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE REQUIRED PROPERTY name: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  ALTER TYPE default::Collection {
      CREATE MULTI LINK aliases := (.<collection[IS default::Alias_name]);
      ALTER PROPERTY name {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  CREATE TYPE default::ApprovedToken {
      CREATE REQUIRED PROPERTY expires_at: std::datetime;
      CREATE REQUIRED PROPERTY issued_at: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY jti: std::uuid;
      CREATE REQUIRED PROPERTY token: std::str;
  };
  ALTER TYPE default::Chat {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::Chat {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              chats += __new__
          });
  };
  ALTER TYPE default::Chunk {
      CREATE REQUIRED PROPERTY content_hash: std::bytes {
          SET default := (ext::pgcrypto::digest((.content ?? ''), 'sha256'));
          CREATE REWRITE
              INSERT 
              USING (ext::pgcrypto::digest((.content ?? ''), 'sha256'));
          CREATE REWRITE
              UPDATE 
              USING (ext::pgcrypto::digest((.content ?? ''), 'sha256'));
      };
  };
  CREATE TYPE default::ChunkVersion {
      CREATE SINGLE LINK chunk: default::Chunk {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE MULTI LINK trash: default::ChunkVersion {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY content: std::str;
      CREATE PROPERTY contentType: std::str;
      CREATE PROPERTY content_hash: std::bytes;
      CREATE PROPERTY payload: std::json {
          SET default := (std::to_json('{}'));
      };
      CREATE REQUIRED PROPERTY ts: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE TRIGGER erase
          AFTER INSERT 
          FOR ALL DO (DELETE
              __new__.trash
          );
  };
  ALTER TYPE default::Chunk {
      CREATE TRIGGER keep_prev_version
          AFTER UPDATE 
          FOR EACH 
              WHEN ((__new__.content_hash != __old__.content_hash))
          DO (INSERT
              default::ChunkVersion
              {
                  trash := __old__.<chunk[IS default::ChunkVersion],
                  ts := std::datetime_current(),
                  content := (__old__.content ?? ''),
                  content_hash := __old__.content_hash,
                  contentType := __old__.contentType,
                  payload := __old__.payload,
                  chunk := __new__
              });
      ALTER PROPERTY modified {
          DROP REWRITE
              UPDATE ;
          };
      };
  ALTER TYPE default::Chunk {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::Chunk {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              chunks += __new__
          });
  };
  CREATE TYPE default::bucket {
      CREATE PROPERTY log_count_ChunkVersion: std::int16;
      CREATE TRIGGER erase
          AFTER UPDATE 
          FOR ALL 
              WHEN ((__new__.log_count_ChunkVersion > 2))
          DO (WITH
              a := 
                  ((SELECT
                      default::ChunkVersion ORDER BY
                          .ts DESC
                  OFFSET
                      1
                  LIMIT
                      2
                  )).id
          DELETE
              default::ChunkVersion
          FILTER
              NOT ((.id IN a))
          );
  };
  ALTER TYPE default::Dashbord {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::Dashbord {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              dashbord += __new__
          });
  };
  ALTER TYPE default::DataBaseHub {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::DataBaseHub {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              databases += __new__
          });
  };
  ALTER TYPE default::File {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::File {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              files += __new__
          });
  };
  ALTER TYPE default::Folder {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::Folder {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              folders += __new__
          });
  };
  ALTER TYPE default::Prompt {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::Prompt {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              prompts += __new__
          });
  };
  ALTER TYPE default::Tag {
      DROP TRIGGER insert_in_collection;
  };
  ALTER TYPE default::Tag {
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR ALL DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection_id)
          SET {
              tags += __new__
          });
  };
};
