#!/plone/instance/bin/zopepy
# -*- coding: ascii -*-
####################################
# Modified version of
# http://svn.plone.org/svn/plone/buildouts/plone-coredev/branches/4.2/unifyChangelogs.py
# extended to recognise more history/docs paths and handle git repos better
#
# usage:
# run in the root of the buildout
# > ./tools/unifyChnagelogs.py <URL_TO_PREVIOUS_VERSIONS.CFG>  <URL_TO_LATEST_VERSIONS.CFG>
# Example:
# > ./tools/unifyChangelogs.py 'http://taskman.eionet.europa.eu/projects/zope/repository/revisions/32379/raw/trunk/www.eea.europa.eu/trunk/versions.cfg' 'http://taskman.eionet.europa.eu/projects/zope/repository/raw/trunk/www.eea.europa.eu/trunk/versions.cfg' > release-notes-2013-03-18.txt
#
# Antonio De Marinis (EEA) [demarant]
#####################################

import contextlib
import urllib2
from distutils.version import StrictVersion
from docutils.core import publish_doctree
import sys

SOURCES = 'https://raw.githubusercontent.com/eea/eea.plonebuildout.core/master/buildout-configs/sources.cfg'

def pullVersions(versionsFile, verbose=False):
    #from ordereddict import OrderedDict
    from collections import OrderedDict
    packageVersions = OrderedDict()
    for line in versionsFile:
        line = line.strip().replace(" ","")
        if line and not (line.startswith('#') or line.startswith('[')):
            try:
                package, version = line.split("=")
                version = StrictVersion(version)
            except ValueError:
                pass
            else:
                packageVersions[package] = version
    return packageVersions

def pullSources(sourcesFile, verbose=False):
    sources = {}
    for line in sourcesFile:

        if line.find('pushurl') != -1:
            index = line.index('pushurl') - 1
            line = line[:index]

        line = line.strip().replace(" ","")
        for t in ['svn','git']:
            line = line.replace("=%s" % t,";;")

        if line and not (line.startswith('#') or line.startswith('[')):
            try:
                package, location = line.split(";;")
                if location.endswith(".git"):
                    location = location[:-4]
                sources[package] = location
            except ValueError:
                if verbose:
                    print "ERROR pulling SOURCE location from line:"
                    print line

    return sources

def main():
    priorVersionsFileURL = sys.argv[1]
    currentVersionsFileURL = sys.argv[2]
    verbose = sys.argv[3] if len(sys.argv) > 3 else False

    priorVersionsFile = urllib2.urlopen(priorVersionsFileURL)
    priorVersions = pullVersions(priorVersionsFile)

    currentVersionsFile = urllib2.urlopen(currentVersionsFileURL)
    currentVersions = pullVersions(currentVersionsFile)

    sources = {}
    with contextlib.closing(urllib2.urlopen(SOURCES)) as sourcesFile:
        sources = pullSources(sourcesFile)
    outputStr = "\n=============== Unified Changelog ===============\n"

    for package, version in currentVersions.iteritems():
        if package in priorVersions:
            priorVersion = priorVersions[package]
            try:
                newer_version = version > priorVersion
            except AttributeError:
                if verbose:
                    print "AttributeError comparing version"
                newer_version = False

            if newer_version:

                packageChange = u"%s: %s %s %s" % (package, priorVersion, u"\u2192", version)
                outputStr += u"\n" + packageChange + u"\n" + u"-"*len(packageChange) + "\n"
                if verbose:
                    print "\n"
                    print packageChange.encode('utf-8')
                    print "========================================"
                if package in sources:
                    source = sources[package]
                    if verbose:
                        print "Looking for CHANGES.txt/HISTORY.txt in source:"
                        print source
                    for structure in ["CHANGES.txt",
                                      "HISTORY.txt",
                                      "docs/CHANGES.txt",
                                      "docs/HISTORY.txt",
                                      "raw/master/CHANGES.txt",
                                      "raw/master/HISTORY.txt",
                                      "raw/master/docs/CHANGES.txt",
                                      "raw/master/docs/HISTORY.txt"]:
                        if verbose:
                            print "%s/%s" % (source, structure)

                        try:
                            response = urllib2.urlopen("%s/%s" % (source, structure))
                        except urllib2.HTTPError, e:
                            if verbose:
                                print e.code
                        else:
                            if verbose:
                                print "FOUND %s" % structure
                            break

                    logtext = response.read()
                    tree = publish_doctree(logtext)

                    def isValidVersionSection(x):
                        if x.tagname == "section":
                            try:
                                logVersion = StrictVersion(x['names'][0].split()[0])
                            except ValueError:
                                if verbose:
                                    print "NO section found"
                                pass
                            else:
                                return logVersion > priorVersion and logVersion <= version
                        return False
                    foundSections = tree.traverse(condition=isValidVersionSection)
                    if foundSections:
                        outputStr += u"\n"
                        for s in foundSections:
                            s.children[-1]
                            childlist = s.children[-1]
                            bullet = "- "
                            for child in childlist.children:
                                text = child.astext()
                                text = text.replace("\n","\n" + " "*len(bullet))
                                outputStr += bullet + text + u"\n"
                else:
                    outputStr += u"\n"
                    outputStr += "- https://pypi.python.org/pypi/%s#changelog" % package
                    outputStr += u"\n"

    print outputStr.encode('utf-8')

if __name__ == "__main__":
    main()
