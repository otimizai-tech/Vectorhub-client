CREATE MIGRATION m1lz3f6swp2pbhjvg6zto3knfrk6rtjs3aafqnkrs4pbagbhhyan6q
    ONTO m1ts6n3am4pkdyaivexenz5yoqdfypprwn6ocsa7adfrymzhymvkfa
{
  ALTER TYPE default::Chunk {
      DROP ACCESS POLICY acess_collection;
  };
  ALTER TYPE default::Chunk {
      CREATE ACCESS POLICY acess_collection_d
          ALLOW DELETE USING ((GLOBAL default::current_collection ?= std::assert_single(.<chunks[IS default::Collection].id)));
  };
  ALTER TYPE default::Chunk {
      CREATE ACCESS POLICY acess_collection_s
          ALLOW SELECT USING ((GLOBAL default::current_collection ?= std::assert_single(.<chunks[IS default::Collection].id)));
  };
  ALTER TYPE default::Chunk {
      CREATE ACCESS POLICY acess_collection_u
          ALLOW UPDATE USING ((GLOBAL default::current_collection ?= std::assert_single(.<chunks[IS default::Collection].id)));
  };
};
