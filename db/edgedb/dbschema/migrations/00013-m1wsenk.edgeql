CREATE MIGRATION m1wsenkouaynkk2pwrd24ceaevjn4d2wl3udx2wvrbhmfi2zwj434a
    ONTO m1k4ltmofrbaq4vu3644kncctp7a5fpw2rocmbzimf3mbdnfqqqlma
{
  ALTER TYPE default::ApprovedToken {
      CREATE PROPERTY algorithm: std::str;
      CREATE PROPERTY name_type: std::str {
          SET default := '';
      };
      CREATE PROPERTY revoked: std::bool {
          SET default := false;
      };
  };
  CREATE TYPE default::User {
      CREATE REQUIRED PROPERTY provider: std::str;
      CREATE REQUIRED PROPERTY provider_user_id: std::str;
      CREATE CONSTRAINT std::exclusive ON ((.provider, .provider_user_id));
      CREATE MULTI LINK tokens: default::ApprovedToken {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY avatar_url: std::str;
      CREATE PROPERTY created_at: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY email: std::str;
      CREATE PROPERTY is_active: std::bool {
          SET default := true;
      };
      CREATE PROPERTY last_login: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE REQUIRED PROPERTY name: std::str;
      CREATE PROPERTY role: std::str {
          SET default := 'user';
      };
  };
};
