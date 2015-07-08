<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the resource MedicationDispense
    It is provided for documentation purposes. When actually validating,
    always use fhir-invariants.sch (because of the way containment works)
    Alternatively you can use this file to build a smaller version of
    fhir-invariants.sch (the contents are identical; only include those 
    resources relevant to your implementation).
  -->
    <sch:pattern>
      <sch:title>Global</sch:title>
      <sch:rule context="f:*">
        <sch:assert test="@value|f:*|h:div">global-1: All FHIR elements must have a @value or children</sch:assert>
      </sch:rule>
    </sch:pattern>
  <sch:pattern>
    <sch:title>MedicationDispense</sch:title>
    <sch:rule context="f:MedicationDispense">
      <sch:assert test="not(parent::f:contained and f:contained)">dom-2: If the resource is contained in another resource, it SHALL NOT contain nested Resources</sch:assert>
      <sch:assert test="not(parent::f:contained and f:text)">dom-1: If the resource is contained in another resource, it SHALL NOT contain any narrative</sch:assert>
      <sch:assert test="not(exists(f:contained/f:meta/f:versionId)) and not(exists(f:contained/f:meta/f:lastUpdated))">dom-4: If a resource is contained in another resource, it SHALL NOT have a meta.versionId or a meta.lastUpdated</sch:assert>
      <sch:assert test="not(exists(for $id in f:contained/*/@id return $id[not(ancestor::f:contained/parent::*/descendant::f:reference/@value=concat('#', $id))]))">dom-3: If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:text/f:div">
      <sch:assert test="not(descendant-or-self::*/@*[not(name(.)=('abbr', 'accesskey', 'align', 'alt', 'axis', 'bgcolor', 'border', 'cellhalign', 'cellpadding', 'cellspacing', 'cellvalign', 'char', 'charoff', 'charset', 'cite', 'class', 'colspan', 'compact', 'coords', 'dir', 'frame', 'headers', 'height', 'href', 'hreflang', 'hspace', 'id', 'lang', 'longdesc', 'name', 'nowrap', 'rel', 'rev', 'rowspan', 'rules', 'scope', 'shape', 'span', 'src', 'start', 'style', 'summary', 'tabindex', 'title', 'type', 'valign', 'value', 'vspace', 'width'))])">txt-3: The narrative SHALL contain only the basic html formatting attributes described in chapters 7-11 (except section 4 of chapter 9) and 15 of the HTML 4.0 standard, &lt;a&gt; elements (either name or href), images and internally contained style attributes</sch:assert>
      <sch:assert test="not(descendant-or-self::*[not(local-name(.)=('a', 'abbr', 'acronym', 'b', 'big', 'blockquote', 'br', 'caption', 'cite', 'code', 'colgroup', 'dd', 'dfn', 'div', 'dl', 'dt', 'em', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'hr', 'i', 'img', 'li', 'ol', 'p', 'pre', 'q', 'samp', 'small', 'span', 'strong', 'table', 'tbody', 'td', 'tfoot', 'th', 'thead', 'tr', 'tt', 'ul', 'var'))])">txt-1: The narrative SHALL contain only the basic html formatting elements described in chapters 7-11 (except section 4 of chapter 9) and 15 of the HTML 4.0 standard, &lt;a&gt; elements (either name or href), images and internally contained style attributes</sch:assert>
      <sch:assert test="descendant::text()[normalize-space(.)!=''] or descendant::h:img[@src]">txt-2: The narrative SHALL have some non-whitespace content</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense">
      <sch:assert test="not(exists(f:whenHandedOver/@value)) or not(exists(f:whenPrepared/@value)) or ( f:whenHandedOver/@value &gt;= f:whenPrepared/@value)">mdd-1: whenHandedOver cannot be before whenPrepared</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:identifier/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">per-1: If present, start SHALL have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:identifier/f:assigner">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:patient">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dispenser">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:authorizingPrescription">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:quantity">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:daysSupply">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:medicationReference">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:destination">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:receiver">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:schedulePeriod">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">per-1: If present, start SHALL have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat">
      <sch:assert test="not(exists(f:periodMax)) or exists(period)">tim-6: If there's a periodMax, there must be a period</sch:assert>
      <sch:assert test="not(exists(f:durationMax)) or exists(duration)">tim-7: If there's a durationMax, there must be a duration</sch:assert>
      <sch:assert test="not(exists(f:duration)) or exists(f:durationUnits)">tim-1: if there's a duration, there needs to be duration units</sch:assert>
      <sch:assert test="not(exists(f:period)) or exists(f:periodUnits)">tim-2: if there's a period, there needs to be duration units</sch:assert>
      <sch:assert test="not(exists(f:frequency)) or not(exists(f:when))">tim-3: Either frequency or when can exist, not both</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:boundsDuration">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:boundsRange">
      <sch:assert test="not(exists(f:low/f:value/@value)) or not(exists(f:high/f:value/@value)) or (number(f:low/f:value/@value) &lt;= number(f:high/f:value/@value))">rng-2: If present, low SHALL have a lower value than high</sch:assert>
      <sch:assert test="not(exists(f:low/f:comparator) or exists(f:high/f:comparator))">rng-3: Quantity values cannot have a comparator when used in a Range</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:boundsRange/f:low">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:boundsRange/f:high">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:boundsPeriod">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">per-1: If present, start SHALL have a lower value than end</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:duration">
      <sch:assert test="@value &gt;= 0 or not(@value)">tim-4: duration SHALL be a non-negative value</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:scheduleTiming/f:repeat/f:period">
      <sch:assert test="@value &gt;= 0 or not(@value)">tim-5: period SHALL be a non-negative value</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:doseRange">
      <sch:assert test="not(exists(f:low/f:value/@value)) or not(exists(f:high/f:value/@value)) or (number(f:low/f:value/@value) &lt;= number(f:high/f:value/@value))">rng-2: If present, low SHALL have a lower value than high</sch:assert>
      <sch:assert test="not(exists(f:low/f:comparator) or exists(f:high/f:comparator))">rng-3: Quantity values cannot have a comparator when used in a Range</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:doseRange/f:low">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:doseRange/f:high">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:doseQuantity">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:rate">
      <sch:assert test="(count(f:numerator) = count(f:denominator)) and ((count(f:numerator) &gt; 0) or (count(f:extension) &gt; 0))">rat-1: numerator and denominator SHALL both be present, or both be absent. If both are absent, there SHALL be some extension present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:rate/f:numerator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:rate/f:denominator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:maxDosePerPeriod">
      <sch:assert test="(count(f:numerator) = count(f:denominator)) and ((count(f:numerator) &gt; 0) or (count(f:extension) &gt; 0))">rat-1: numerator and denominator SHALL both be present, or both be absent. If both are absent, there SHALL be some extension present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:maxDosePerPeriod/f:numerator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:dosageInstruction/f:maxDosePerPeriod/f:denominator">
      <sch:assert test="not(exists(f:code)) or exists(f:system)">qty-3: If a code for the units is present, the system SHALL also be present</sch:assert>
    </sch:rule>
    <sch:rule context="f:MedicationDispense/f:substitution/f:responsibleParty">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    </sch:pattern>
</sch:schema>
