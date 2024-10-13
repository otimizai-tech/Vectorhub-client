CREATE MIGRATION m1j4d42dov4o7homfqejdjdbtuworndmyief7bdinmq2i3zqizmi4q
    ONTO m1i3ulast4kn2vdel72qmwhkbqluhgvwd2vb3yvjltx7fotmvm7dua
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY tags {
          USING (<std::json>[.<chunks[IS default::Tag].name]);
      };
  };
};
