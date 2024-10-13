CREATE MIGRATION m1kkh3hc4u42ce63hduv6df5dyoid5e7rvcikbjcidh7l6wi3jvyea
    ONTO m1j4d42dov4o7homfqejdjdbtuworndmyief7bdinmq2i3zqizmi4q
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY tags {
          USING (<std::json>.<chunks[IS default::Tag].name);
      };
  };
};
