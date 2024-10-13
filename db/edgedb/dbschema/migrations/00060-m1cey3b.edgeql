CREATE MIGRATION m1cey3bd7tlqmhsqqwrmdj6orxhscc544xyh7skacqgtbztsd6zh7q
    ONTO m1ritz6eci54aglixhjmx5abckoeldign27dfmedyfa32qfla6cofa
{
  ALTER GLOBAL default::current_collection RENAME TO default::current_collection_id;
  CREATE GLOBAL default::current_collection_name -> std::str;
  ALTER TYPE default::Chat {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chats[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chats[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chats[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chats[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chats[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chats[IS default::Collection].name))));
  };
  ALTER TYPE default::Chunk {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chunks[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chunks[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chunks[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chunks[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<chunks[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<chunks[IS default::Collection].name))));
  };
  ALTER TYPE default::Dashbord {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<dashbord[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<dashbord[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<dashbord[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<dashbord[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<dashbord[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<dashbord[IS default::Collection].name))));
  };
  ALTER TYPE default::DataBaseHub {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<databases[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<databases[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<databases[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<databases[IS default::Collection].name))));
  };
  ALTER TYPE default::File {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<files[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<files[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<files[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<files[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<files[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<files[IS default::Collection].name))));
  };
  ALTER TYPE default::Folder {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<folders[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<folders[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<folders[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<folders[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<folders[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<folders[IS default::Collection].name))));
  };
  ALTER TYPE default::Prompt {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<prompts[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<prompts[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<prompts[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<prompts[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<prompts[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<prompts[IS default::Collection].name))));
  };
  ALTER TYPE default::Tag {
      ALTER ACCESS POLICY acess_collection_d USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<tags[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<tags[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_s USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<tags[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<tags[IS default::Collection].name))));
      ALTER ACCESS POLICY acess_collection_u USING (((GLOBAL default::current_collection_id ?= std::assert_single(.<tags[IS default::Collection].id)) OR (GLOBAL default::current_collection_name ?= std::assert_single(.<tags[IS default::Collection].name))));
  };
};
