CREATE MIGRATION m1jpg3d7gpycixuogoqkhtmsk37jfkfemjb5t4paayee7brbojul4a
    ONTO m1flhbfqmbnkq3cmerecp52ukwslv55cx2gzswzc3r6n3hcwcgiota
{
  ALTER TYPE default::Chat {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<chats[IS default::Collection].id)));
  };
  ALTER TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<chats[IS default::Collection].id)));
  };
  ALTER TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<chats[IS default::Collection].id)));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              chats += __new__
          });
  };
  ALTER TYPE default::Dashbord {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::Dashbord {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<dashbord[IS default::Collection].id)));
  };
  ALTER TYPE default::Dashbord {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::Dashbord {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<dashbord[IS default::Collection].id)));
  };
  ALTER TYPE default::Dashbord {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<dashbord[IS default::Collection].id)));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              dashbord += __new__
          });
  };
  ALTER TYPE default::DataBaseHub {
      DROP ACCESS POLICY acess_collection;
      CREATE PROPERTY config: std::json;
  };
  ALTER TYPE default::File {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::File {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<files[IS default::Collection].id)));
  };
  ALTER TYPE default::File {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::File {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<files[IS default::Collection].id)));
  };
  ALTER TYPE default::File {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<files[IS default::Collection].id)));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              files += __new__
          });
  };
  ALTER TYPE default::Folder {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::Folder {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<folders[IS default::Collection].id)));
  };
  ALTER TYPE default::Folder {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::Folder {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<folders[IS default::Collection].id)));
  };
  ALTER TYPE default::Folder {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<folders[IS default::Collection].id)));
  };
  ALTER TYPE default::Prompt {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::Prompt {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<prompts[IS default::Collection].id)));
  };
  ALTER TYPE default::Prompt {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::Prompt {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<prompts[IS default::Collection].id)));
  };
  ALTER TYPE default::Prompt {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<prompts[IS default::Collection].id)));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              prompts += __new__
          });
  };
  ALTER TYPE default::Tag {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::Tag {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<tags[IS default::Collection].id)));
  };
  ALTER TYPE default::Tag {
      CREATE ACCESS POLICY acess_collection_i
          ALLOW INSERT USING ((.id ?= .id));
  };
  ALTER TYPE default::Tag {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<tags[IS default::Collection].id)));
  };
  ALTER TYPE default::Tag {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<tags[IS default::Collection].id)));
      CREATE TRIGGER insert_in_collection
          AFTER INSERT 
          FOR EACH DO (UPDATE
              default::Collection
          FILTER
              (.id = GLOBAL default::current_collection)
          SET {
              tags += __new__
          });
  };
};
