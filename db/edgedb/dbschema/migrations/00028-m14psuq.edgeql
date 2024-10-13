CREATE MIGRATION m14psuqhtws655jik4oijxcj4gnn5bvs5cql36gu4625ouweo4mf3a
    ONTO m1kkh3hc4u42ce63hduv6df5dyoid5e7rvcikbjcidh7l6wi3jvyea
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY tags {
          USING (.<chunks[IS default::Tag].name);
      };
  };
};
