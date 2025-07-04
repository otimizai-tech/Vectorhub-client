CREATE MIGRATION m1kc6ahxfvxrdgw3awwpjrfi4pvu2aslfmcf3d4l4e5giskho2vzpq
    ONTO m1ylkij7wncrwg5b5ibptv5uy2fje3bjc2cmh3fhebrafhfypktz5a
{
  ALTER TYPE default::Chunk {
      ALTER PROPERTY modified {
          SET default := (std::datetime_current());
      };
  };
};
