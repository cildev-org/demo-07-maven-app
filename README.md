# demo-07-maven-app

Blue-Oryx demo target: a Maven application dependency PR (vulnerable on purpose).

A tiny Java web app whose `/render` runs user input through Apache Commons
Text's `StringSubstitutor`. `pom.xml` pins `commons-text 1.9`, which has
CVE-2022-42889 (Text4Shell): the `url` interpolation lookup is on by default,
so `${url:...}` makes the app fetch a URL. The fix is `commons-text 1.10.0`.

Blue-Oryx opens a pull request that moves the `<version>` to 1.10.0; after it
is merged and deployed, the same exploit is blocked.
