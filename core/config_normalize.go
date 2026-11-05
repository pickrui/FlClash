package main

import (
	"gopkg.in/yaml.v3"
)

func normalizeConfigShortIds(data []byte) []byte {
	var root yaml.Node
	if err := yaml.Unmarshal(data, &root); err != nil {
		return data
	}
	if !retagShortIds(&root, "") {
		return data
	}
	out, err := yaml.Marshal(&root)
	if err != nil {
		return data
	}
	return out
}

func retagShortIds(node *yaml.Node, parentKey string) bool {
	changed := false
	switch node.Kind {
	case yaml.DocumentNode, yaml.SequenceNode:
		for _, child := range node.Content {
			if retagShortIds(child, parentKey) {
				changed = true
			}
		}
	case yaml.MappingNode:
		for i := 0; i+1 < len(node.Content); i += 2 {
			key := node.Content[i]
			value := node.Content[i+1]
			if parentKey == "reality-opts" &&
				key.Value == "short-id" &&
				value.Kind == yaml.ScalarNode &&
				(value.Tag == "!!int" || value.Tag == "!!float") {
				value.Tag = "!!str"
				value.Style = yaml.DoubleQuotedStyle
				changed = true
				continue
			}
			if retagShortIds(value, key.Value) {
				changed = true
			}
		}
	}
	return changed
}
