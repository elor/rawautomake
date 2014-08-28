#ifndef CONFIG_HPP_
#define CONFIG_HPP_

const struct config_t
{
  const char *longname = "CHANGETHIS";
  const char *version = "0.0prealpha";
  const char *author = "Erik E. Lorenz";
  const char *email = "erik.e.lorenz@gmail.com";
  const char *copyrightHolder = "Erik E. Lorenz";
  const unsigned int copyrightFrom = 2014;
  const unsigned int copyrightTo = 2014;
} config;

void printVersionAndExit(void)
{
  log << config.longname << " version " << config.version << endl;
  log << "Copyright (C) ";

  if (config.copyrightFrom == config.copyrightTo)
    log << config.copyrightFrom;
  else
    log << config.copyrightFrom << "-" << config.copyrightTo;

  log << " " << config.copyrightHolder << endl;

  log << "Author: " << config.author << " <" << config.email << ">" << endl;
  exit(0);
}

void printVersionAndExit(void*)
{
  printVersionAndExit();
}

#endif /* CONFIG_HPP_ */
