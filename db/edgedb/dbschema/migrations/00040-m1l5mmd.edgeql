CREATE MIGRATION m1l5mmd2kap5vvn7uyz2wsrtsep4bww7bqgcllrtncwjsk7zf2zxjq
    ONTO m1bonp6dp5ryhsetyoc5e4y6tpucm2uvbm7s4pyurkc3jwniqzzgfq
{
  ALTER TYPE default::Chat {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<chats[IS default::Collection].id)));
  };
  ALTER TYPE default::Collection {
      CREATE MULTI LINK chunks: default::Chunk {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      DROP ACCESS POLICY acess;
  };
  ALTER TYPE default::Chunk {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<chunks[IS default::Collection].id)));
  };
  ALTER TYPE default::Dashbord {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<dashbord[IS default::Collection].id)));
  };
  ALTER TYPE default::DataBaseHub {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<databases[IS default::Collection].id)));
  };
  ALTER TYPE default::File {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<files[IS default::Collection].id)));
  };
  ALTER TYPE default::Folder {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<folders[IS default::Collection].id)));
  };
  ALTER TYPE default::Prompt {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<prompts[IS default::Collection].id)));
  };
  ALTER TYPE default::Tag {
      CREATE ACCESS POLICY acess_collection
          ALLOW ALL USING ((GLOBAL default::current_collection ?= std::assert_single(.<tags[IS default::Collection].id)));
  };
};
