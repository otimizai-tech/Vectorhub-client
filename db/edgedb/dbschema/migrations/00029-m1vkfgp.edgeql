CREATE MIGRATION m1vkfgpwvn6pn2as3edo7u4mausnxnyayq675kzp5wihtdkr7qmg4a
    ONTO m14psuqhtws655jik4oijxcj4gnn5bvs5cql36gu4625ouweo4mf3a
{
  ALTER TYPE default::Chunk {
      DROP PROPERTY database;
  };
  ALTER TYPE default::Chunk {
      CREATE LINK database: default::DataBaseHub;
      DROP LINK hold_database;
  };
  ALTER TYPE default::Chunk {
      DROP PROPERTY tags;
  };
  ALTER TYPE default::Chunk {
      CREATE MULTI LINK tags := (.<chunks[IS default::Tag]);
  };
};
