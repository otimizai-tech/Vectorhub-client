CREATE MIGRATION m1wilnoif4nynoot2iw5hoyrgxjpvg2ikiaecxtgmksleuyz7uswuq
    ONTO m1dc5zvr3tfymmqmvcgib42lddm2o3p3sssgwmltrd2bof6wcv7yda
{
  ALTER TYPE default::Movie {
      CREATE PROPERTY title2: std::str;
  };
};
